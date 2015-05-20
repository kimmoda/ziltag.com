class ArrayHelperTest < ActionView::TestCase
  test '#slice_transpose' do
    ary = (1..10).to_a
    assert_equal [[1,3,5,7,9], [2,4,6,8,10]], slice_transpose(ary, 2)
    assert_equal [[1,4,7,10], [2,5,8], [3,6,9]], slice_transpose(ary, 3)
    assert_equal [[1,5,9], [2,6,10], [3,7], [4,8]], slice_transpose(ary, 4)
  end
end