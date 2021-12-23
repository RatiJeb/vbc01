module PostServices
  class UpdatePost
    attr_accessor :post, :params

    def initialize(post, params)
      @post = post
      @params = params
    end

    def call(action:)
      case action
      when 'draft'
        post.mark_as_draft!
      when 'moderation'
        post.process_on_moderation!
      when 'published'
        moderator = User.find(params[:moderator_id])

        post.mark_as_published!(moderator)
      else
        post.update!(params)
      end
    rescue => e
      post.errors.add(:base, e)
      false
    end
  end
end