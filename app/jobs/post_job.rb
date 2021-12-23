class PostJob < ApplicationJob
  queue_as :posts

  def perform(*args)
    post = args.first

    PostInteractors::UpdatePost.call(
      additional_params: { action: 'moderation', moderator_id: post.moderator_id },
      post: post
    )
  end

end