class HomeController < ApplicationController
  def homepage
  end

  def encrypt
    return render(json: "Error") if params[:message].nil? || params[:type].nil?

    response = encrypt_message(params[:message].upcase, params[:type].to_i)
    render(json: response)
  end

  def decrypt
    return render(json: "Error") if params[:code].nil? || params[:type].nil?

    response = decrypt_code(params[:code].upcase, params[:type].to_i)
    render(json: response)
  end

  private

  def encrypt_message(message, type)
    message = message.gsub(/[^0-9a-zA-Z ]/i, '')
    factor = message.length * type
    result = ""
    message.each_char do |char|
      encrypted = (get_number(char) - factor) % available_char.length
      result += get_char(encrypted)
    end
    result
  end

  def decrypt_code(code, type)
    code = code.gsub(/[^0-9a-zA-Z ]/i, '')
    factor = code.length * type
    result = ""
    code.each_char do |char|
      decrypted = (get_number(char) + factor) % available_char.length
      result += get_char(decrypted)
    end
    result
  end

  def get_char(number)
    available_char[number.to_i]
  end

  def get_number(char)
    char_info = char.to_s.upcase
    available_char.each_char.with_index do |c,i|
      return i if c == char_info
    end
    nil
  end

  def available_char
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "
  end
end
