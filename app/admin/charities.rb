ActiveAdmin.register Charity do
  menu :if => proc{ can?(:manage, Charity) }
end
