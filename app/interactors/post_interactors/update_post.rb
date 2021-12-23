module PostInteractors
  class UpdatePost
    include Interactor

    def call
      case context.additional_params[:action]

      when 'draft'
        context.post.mark_as_draft!

      when 'moderation'
        context.post.process_on_moderation!

      when 'schedule'
        context.post.process_scheduled!(context.params[:scheduled_at])
        PostJob.set(wait_until: context.params[:scheduled_at].to_datetime - 4.hours).perform_later(context.post)

      when 'publish'
        moderator = User.find(context.additional_params[:moderator_id])
        context.post.mark_as_published!(moderator)

      when 'cancel'
        moderator = User.find(context.additional_params[:moderator_id])        
        context.post.mark_as_canceled!(moderator, context.additional_params[:cancellation_reason])

      else
        context.post.update!(context.params)
      end

    rescue => e
      context.post.errors.add(:base, e)
      context.fail!(message: e)
    end
  end
end