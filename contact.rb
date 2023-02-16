require 'sinatra/activerecord'

class Contact < ActiveRecord::Base
  attr_accessor :f_name, :l_name, :number

  # def initialize(f_name, l_name, number)
  #   @f_name = f_name
  #   @l_name = l_name
  #   @number = number
  # end

  def to_obj
    {
      f_name: @f_name,
      l_name: @l_name,
      number: @number,
    }
  end

end