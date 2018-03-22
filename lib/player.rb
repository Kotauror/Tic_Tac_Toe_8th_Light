class Player

  attr_reader :name, :sign

  def initialize(name)
    @name = name
    @sign = nil
  end

  def set_up_sign(sign)
    if sign.length == 1 then
      @sign = sign
    end
  end

end
