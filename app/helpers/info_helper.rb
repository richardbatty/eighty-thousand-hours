module InfoHelper
  def page_title
    content_tag :title do
      "High Impact Careers" + ( @title ? " - #{@title}" : "" )
    end
  end

  def pledge
    "I pledge that, over my lifetime, I will dedicate 10% of my time or money,
    or any combination of the two, to those causes that I believe will do the
    most good with the resources I give them.  I understand that it is
    difficult to know the best way of doing good in the world, and so I will
    choose those cause(s) on the basis of the best evidence that is available
    to me at the time.  Further, I will deliberately pursue a career that will
    considerably enhance my ability to further those causes I believe to be
    best."
  end
end

