require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:blog) { create(:blog) }
  let(:user) { create(:user) }

  context "search" do
    let(:blog) { create(:blog, :blog_with_comment) }
    subject { Blog.find_with_comments(blog.id) }
    it "success" do
      expect(subject.comments.size).to eq(3)
    end
  end

  context "search" do
    let(:search_param) { nil }
    subject { Blog.search_body(search_param) }

    context 'without search_param' do
      it "all blogs" do
        expect(subject.size).to eq(Blog.all.size)
      end
    end

    context 'wit search_param' do
      let(:search_param) { @timestamp }
      before {
        timestamp!
        create(:blog, body: "<h1>Title#{@timestamp}</h1>")
      }
      it '1 record' do
        expect(subject.size).to eq(1)
      end
    end
  end

  context "has_favorites?" do
    subject { blog.has_favorites?(user) }

    context 'has no favorites' do
      it "false" do
        expect(subject).to eq(false)
      end
    end

    context 'has favorites' do
      before {
        blog.like(user.id)
      }
      it "true" do
        expect(subject).to eq(true)
      end
    end
  end

  context "like/unlike" do
    it "anable to switch like unlike" do
      blog.like(user.id)
      expect(blog.favorites.size).to eq(1)
      expect(blog.favorites.first.user_id).to eq(user.id)

      blog.unlike(user.id)
      expect(blog.favorites.size).to eq(0)
    end
  end
end
