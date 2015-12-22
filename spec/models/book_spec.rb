require 'spec_helper'

RSpec.describe Book, type: :model do
  describe "#set_processed_title" do
  	
  	before { book.save }

  	let(:book) { described_class.new(title: title) }
  	let(:expected_processed_title) { 'book' }

  	context 'title starts with stop word' do
  		let(:title) { 'a book' }
  	
	  	it "makes sure processed_title is not empty" do
	  		expect(book.processed_title).to eq(expected_processed_title)
	  	end
  	end

  	context 'title without stop word' do
  		let(:title) { 'book' }
  	
	  	it "makes sure processed_title is not empty" do
	  		expect(book.processed_title).to eq(expected_processed_title)
	  	end
  	end

  end
end




