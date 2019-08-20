DATE_NOW = Date.today

shared_examples_for "check that basic operations with postgres works correctly for time key" do |class_name|

  let!(:subject) do
    class_name.reset_column_information
    class_name
  end

  context "when try to create one record" do

    it "record created" do
      expect { subject.create(:name => 'Phil', :company_id => 3, :created_at => DATE_NOW + 1, :tags => ['IT', 'Finance'])
      }.not_to raise_error
    end

  end # when try to create one record

  context "when try to create one record using new/save" do

    it "record created" do
      expect {
        instance = subject.new(:name => 'Mike', :company_id => 1, :created_at => DATE_NOW + 1, :tags => ['IT', 'Finance'])
        instance.save!
      }.not_to raise_error
    end

  end # when try to create one record using new/save

  context "when try to find a record with the search term is id" do

    it "returns employee name" do
      expect(subject.find(1).name).to eq("Keith")
    end

  end # when try to find a record with the search term is id

  context "when try to find a record with the search term is name" do

    it "returns employee name" do
      expect(subject.where(:name => 'Keith').first.name).to eq("Keith")
    end

  end # when try to find a record with the search term is name

  context "when try to find a record with the search term is company_id" do

    it "returns employee name" do
      expect(subject.where(:company_id => 1).first.name).to eq("Keith")
    end

  end # when try to find a record with the search term is company_id

  context "when try to find a record which is showing partition table" do

    it "returns employee name" do
      expect(subject.from_partition(DATE_NOW).find(1).name).to eq("Keith")
    end

  end # when try to find a record which is showing partition table

  context "when try to update a record with id = 1" do

    it "returns updated employee name" do
      record = subject.find(1)
      original_created_at = record.created_at
      subject.update(1, :name => 'Kevin')
      result = subject.find(1)
      expect(result.name).to eq "Kevin"
      expect(result.created_at).to eq original_created_at
    end

    it "updates array attributes" do
      subject.update(1, :tags => ['Sales', 'Marketing'])
      result = subject.find(1)
      expect(result.tags).to eq ['Sales', 'Marketing']
    end

  end # when try to update a record with id = 1

  context "when try to delete a record with id = 1" do

    it "returns empty array" do
      subject.delete(1)
      expect(subject.all).to eq([])
    end

  end # when try to delete a record with id = 1

  context "when try to create new record outside the range of partitions" do

    it "raises ActiveRecord::StatementInvalid" do
      expect {
        subject.create(created_at: DATE_NOW - 1.year, company_id: 1)
      }.to raise_error(ActiveRecord::StatementInvalid)
    end

  end # when try to create new record outside the range of partitions

  context "when try to update a record outside the range of partitions" do

    it "raises ActiveRecord::StatementInvalid" do
      expect { subject.update(1, :name => 'Kevin', :created_at => DATE_NOW - 1.year)
      }.to raise_error(ActiveRecord::StatementInvalid)
    end

  end # when try to update a record outside the range of partitions

  context "when try to find a record outside the range of partitions" do

    it "raises ActiveRecord::StatementInvalid" do
      expect { subject.from_partition(DATE_NOW - 1.year).find(1)
      }.to raise_error(ActiveRecord::StatementInvalid)
    end

  end # when try to find a record outside the range of partitions
end # check that basic operations with postgres works correctly for time key
