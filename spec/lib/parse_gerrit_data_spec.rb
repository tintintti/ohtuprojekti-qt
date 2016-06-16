require 'rails_helper'

describe "ParseGerritData" do

  details = IO.read("spec/fixtures/details.json")
  details_parsed = eval(details)

  describe "create_owner" do

    it "saves the owner correctly with valid account_id" do
      single_detail = details_parsed[0]
      ParseGerritData.create_owner(single_detail['owner'])

      expect(GerritOwner.all.count).to be(1)
      expect(GerritOwner.all.first.account_id).to be(1002160)
    end

    it "wont save owner if it is already saved" do
      single_detail = details_parsed[0]
      ParseGerritData.create_owner(single_detail['owner'])
      ParseGerritData.create_owner(single_detail['owner'])

      expect(GerritOwner.all.count).to be(1)
      expect(GerritOwner.all.first.account_id).to be(1002160)
    end
  end

  describe "create_change" do


    it "creates a change with valid data" do
      single_detail = details_parsed[0]
      ParseGerritData.create_change(single_detail, 1)

      expect(GerritChange.all.count).to be(1)
      expect(GerritChange.all.first.id_from_gerrit).to eq("qt%2Fqtbase~dev~I92b24750f498b2548ef0668839c3db21d5a0e320")
      expect(GerritChange.all.first.gerrit_owner_id).to be(1)

    end

    it "wont save a change if it is already saved" do
      single_detail = details_parsed[0]
      ParseGerritData.create_change(single_detail, 1)
      ParseGerritData.create_change(single_detail, 1)

      expect(GerritChange.all.count).to be(1)
      expect(GerritChange.all.first.id_from_gerrit).to eq("qt%2Fqtbase~dev~I92b24750f498b2548ef0668839c3db21d5a0e320")
      expect(GerritChange.all.first.gerrit_owner_id).to be(1)
    end

  end


end
