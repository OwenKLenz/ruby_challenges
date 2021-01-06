class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  def initialize(n)
    @buffer = Array.new(n)
    @read_index = 0
    @write_index = 0
  end

  def read  
    raise BufferEmptyException if @buffer[@read_index].nil?

    read_value = @buffer[@read_index]
    @buffer[@read_index] = nil
    @read_index = increment(@read_index)
    read_value
  end

  def clear
    @buffer.map! { nil }
  end

  def write!(value)
    return if value.nil?

    @read_index = increment(@read_index) unless @buffer[@write_index].nil?
    @buffer[@write_index] = value
    @write_index = increment(@write_index)
  end

  def write(value)
    raise BufferFullException unless @buffer[@write_index].nil?

    write!(value)
  end

  private

  def increment(index)
    index == @buffer.size - 1 ? 0 : index + 1
  end
end