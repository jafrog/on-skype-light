require "skype"

class SkypeCalls
  attr_accessor :status

  def initialize
    @status = call.status
  end

  def calls
    Skype.exec("SEARCH CALLS").split(" ")[1..-1].map(&:to_i)
  end

  def call
    Skype.exec "GET CALL #{calls.first} STATUS"
  end

  def ringing?
    call.status == :ringing
  end

  def inprogress?
    call.status == :inprogress
  end

  def finished_or_missed?
    [:finished, :missed].include? call.status
  end
end
