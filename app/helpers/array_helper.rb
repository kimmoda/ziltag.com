module ArrayHelper
  def slice_transpose ary, number
    ary.each_slice(number).to_a.tap{|x| x.last << nil until x.last.size == number}.transpose.each(&:compact!)
  end
end
