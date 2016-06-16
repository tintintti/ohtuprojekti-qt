require 'rails_helper'

describe "ParseGerritData" do

  details = IO.read("spec/fixtures/details.json")
  details_parsed = eval(details)
  single_detail = details_parsed[0]

  describe "create_owner" do

    before (:each) do
      ParseGerritData.create_owner(single_detail['owner'])
    end

    it "saves the owner correctly with valid account_id" do

      expect(GerritOwner.all.count).to be(1)
      expect(GerritOwner.all.first.account_id).to be(1002160)
    end

    it "wont save owner if it is already saved" do
      ParseGerritData.create_owner(single_detail['owner'])

      expect(GerritOwner.all.count).to be(1)
      expect(GerritOwner.all.first.account_id).to be(1002160)
    end
  end

  describe "create_change" do

    before (:each) do
      ParseGerritData.create_change(single_detail, 1)
    end


    it "creates a change with valid data" do

      expect(GerritChange.all.count).to be(1)
      expect(GerritChange.all.first.id_from_gerrit).to eq("qt%2Fqtbase~dev~I92b24750f498b2548ef0668839c3db21d5a0e320")
      expect(GerritChange.all.first.gerrit_owner_id).to be(1)

    end

    it "wont save a change if it is already saved" do

      ParseGerritData.create_change(single_detail, 1)

      expect(GerritChange.all.count).to be(1)
      expect(GerritChange.all.first.id_from_gerrit).to eq("qt%2Fqtbase~dev~I92b24750f498b2548ef0668839c3db21d5a0e320")
      expect(GerritChange.all.first.gerrit_owner_id).to be(1)
    end

  end

  describe "create_code_review" do

    before (:each) do
      ParseGerritData.create_change(single_detail, 1)
      change = ParseGerritData.create_change(single_detail, 1)
      ParseGerritData.create_code_review(single_detail['labels']['Code-Review']['all'][0], change)
    end

    it "saves a review with valid data" do
      expect(GerritCodeReview.all.count).to be(1)
      expect(GerritCodeReview.all.first.change_id_from_gerrit).to eq("qt%2Fqtbase~dev~I92b24750f498b2548ef0668839c3db21d5a0e320")
    end

  end

  describe "create_sanity_review" do

    before (:each) do
      ParseGerritData.create_change(single_detail, 1)
      change = ParseGerritData.create_change(single_detail, 1)
      ParseGerritData.create_sanity_review(single_detail['labels']['Sanity-Review']['all'][0], change)
    end

    it "saves a review with valid data" do
      expect(GerritSanityReview.all.count).to be(1)
      expect(GerritSanityReview.all.first.change_id_from_gerrit).to eq("qt%2Fqtbase~dev~I92b24750f498b2548ef0668839c3db21d5a0e320")
    end

  end

  describe "create_message" do
    before (:each) do
      ParseGerritData.create_change(single_detail, 1)
      change = ParseGerritData.create_change(single_detail, 1)
      ParseGerritData.create_message(single_detail['messages'][0], change.id)
    end

    it "saves the message even if author is not saved" do
      expect(GerritMessage.all.count).to be(1)
      expect(GerritOwner.all.count).to be(1)
    end

    it "wont save a same author again" do
      ParseGerritData.create_message(single_detail['messages'][0], 1)
      expect(GerritMessage.all.count).to be(2)
      expect(GerritOwner.all.count).to be(1)
    end
  end

  describe "parse_all" do
    before (:each) do
      ParseGerritData.parse_all(details_parsed)
    end

    it "saves the changes correctly" do
      expect(GerritChange.all.count).to be(2)
    end

    it "saves the owners correctly" do
      expect(GerritOwner.all.count).to be(13)
    end

    it "saves the code reviews correctly" do
      expect(GerritCodeReview.all.count).to be(13)
    end

    it "saves the sanity reviews correctly" do
      expect(GerritSanityReview.all.count).to be(13)
    end

    it "saves the messages correctly" do
      expect(GerritMessage.all.count).to be(11)
    end
  end

end
