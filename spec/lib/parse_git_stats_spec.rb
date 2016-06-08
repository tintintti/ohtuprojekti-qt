require 'rails_helper'

describe "ParseGitStats" do

  describe 'baa' do

    author1 = Author.create name:"Ola" , email:"ola@copter.com"
    author2 = Author.create name:"Ola" , email:"blaablaa"
    author3 = Author.create name:"NotOla" , email:"ola@copter.com"
    commit1 = Commit.create repository_id:0, author_id:1, sha:"1" , stamp:1
    commit2 = Commit.create repository_id:0, author_id:2, sha:"1" , stamp:1
    commit3 = Commit.create repository_id:0, author_id:3, sha:"1" , stamp:1
    commit4 = Commit.create repository_id:0, author_id:1, sha:"1" , stamp:1

    it 'links commits from duplicate authors correctly' do
      ParseGitStats.baa
      expect(author1.commits.count).to eq(4)
    end

    it 'links authors correctly' do
      expect(author2.linked_id).to eq(1)
      expect(author3.linked_id).to eq(1)
    end

  end
end