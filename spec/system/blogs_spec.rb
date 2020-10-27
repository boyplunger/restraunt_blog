require "rails_helper"

RSpec.describe "Blogs", type: :system do
  let(:user) { create(:user) }
  let(:login_user) { user }
  let!(:blog) { create(:blog, user: user) }

  before {
    log_in(login_user, type: :system)
    visit blog_path(blog)
  }

  describe 'favorite' do
    context "when own blog" do
      it 'successfully like and dislike' do
        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "fas"
        }
        expect(first("#favorites").text).to eq("1")

        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "far"
        }
        expect(first("#favorites").text).to eq("0")
      end
    end

    context "when other users blog" do
      let(:login_user) { create(:user) }
      it 'successfully like and dislike' do
        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "fas"
        }
        expect(first("#favorites").text).to eq("1")

        first("#favorites a").click
        wait_until {
          first("#favorites svg")["data-prefix"] == "far"
        }
        expect(first("#favorites").text).to eq("0")
      end
    end
  end

  describe 'comment' do
    before {
      timestamp!
    }
    context "when own comment" do
      it 'post and deletable' do
        first("#comments_body").set("Comment#{timestamp}")
        first('#post_comment').click
        wait_until {
          all("#comments div").last.present?
        }
        expect(all("#comments div").last.first("p").text).to eq("Comment#{timestamp}")

        all("#comments div").last.first("a").click
        wait_until(7) {
          # check deleted
          all("#comments div").last.nil?
        }
      end
    end

    context "when other users comment" do
      it 'non display delete link' do
        create(:comment, blog: blog, user: create(:user))
        # page reload
        visit current_path
        wait_until {
          all("#comments div").last.present?
        }
        expect(all("#comments div").last.all("a")).to be_empty
      end
    end
  end
end
