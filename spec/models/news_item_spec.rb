require 'spec_helper'

describe NewsItem do
  describe ".archived_years" do
    let!(:article_2009) { NewsItem.make!(created_at: DateTime.parse('Feb 1, 2009')) }
    let!(:article_2007) { NewsItem.make!(created_at: DateTime.parse('Feb 1, 2007')) }
    let!(:article_2010) { NewsItem.make!(created_at: DateTime.parse('Feb 1, 2010')) }
    subject{ NewsItem.archived_years }
    specify{ subject.should == [2010, 2009, 2007] }
  end
end  
