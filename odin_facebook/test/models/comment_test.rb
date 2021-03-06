require 'test_helper'

class CommentTest < ActiveSupport::TestCase
	def setup
		@user = users(:amr)
		@post = posts(:one)
		@comment = @post.comments.build(content: "Fuck", user_id: @user.id)
	end

	test "should be valid" do
		assert @comment.valid?
	end

	test "content should be present" do
		@comment.content = ""
		assert_not @comment.valid?
	end

	test "user_id should be present" do
		@comment.user_id = nil
		assert_not @comment.valid?
	end

	test "post_id should be present" do
		@comment.post_id = nil
		assert_not @comment.valid?
	end
end
