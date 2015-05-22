require 'test_helper'

class Admin::Select2QuerierTest < ActiveSupport::TestCase
  test '#model_class' do
    assert_equal Post, Admin::Select2Querier.new(:posts).model_class
    assert_equal User, Admin::Select2Querier.new(:users).model_class
    assert_equal Photo, Admin::Select2Querier.new(:photos).model_class
    assert_equal Comment, Admin::Select2Querier.new(:comments).model_class
  end

  test '#search_column' do
    assert_equal :title, Admin::Select2Querier.new(:posts).search_column
    assert_equal :username, Admin::Select2Querier.new(:users).search_column
    assert_equal :source, Admin::Select2Querier.new(:photos).search_column
    assert_equal :text, Admin::Select2Querier.new(:comments).search_column
  end

  test '#query' do
    assert_equal [posts(:tony)], Admin::Select2Querier.new(:posts).query('大兜')
    assert_equal [comments(:tony), comments(:guest)].sort!, Admin::Select2Querier.new(:comments).query('拉拉').to_a.sort!
  end

end
