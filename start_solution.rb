module MethodInstrumenter
  def self.instrument_path(path)
    @path = path
    @counts = 0
    attempt_eager_instrumentation(path)
  end

  def self.instrumented_path
    @path
  end

  def self.path_counts
    @counts
  end

  def self.increment_path_counter
    @counts += 1
  end

  def self.instrumenting?
    @instrumenting
  end

  def self.instrument
    @instrumenting = true
    yield
    @instrumenting = false
  end

  def self.redefine_instance_method(klass, method_name)
    instrument do
      original_method = klass.instance_method(method_name)
      klass.send(:define_method, method_name) do |*args, &blk|
        MethodInstrumenter.increment_path_counter
        original_method.bind(self).call(*args, &blk)
      end
    end
  end

  def self.attempt_eager_instrumentation(path)
    klass_path, method_name = path.split(/[.#]/)
    klass = klass_path.split('::').inject(Object) { |acc, o| acc.const_get(o) }
    if path.include?('#')
      redefine_instance_method(klass, method_name)
    elsif path.include?('.')
      # Need to redefine_class_method(klass, method_name)
    else
      raise ArgumentError, "Unknown path: #{path}"
    end
  rescue => ex
    # we don't know about the class or method yet, i.e., not in the standard lib, included after us
  end
end

class Module
  # use hook(s) to instrument methods
end

class Class
  # use hook(s) to instrument methods
end

MethodInstrumenter.instrument_path(ENV['COUNT_CALLS_TO'])
at_exit do
  if path = ENV['COUNT_CALLS_TO']
    puts '%s called %d times' % [path, MethodInstrumenter.path_counts]
  end
end
