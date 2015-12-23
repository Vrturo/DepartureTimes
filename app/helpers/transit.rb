 def nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end


def hash_flatten h
  h.inject({}) do |a,(k,v)|
    if v.is_a?(Hash)
      hash_flatten(v).each do |sk, sv|
        a[[k]+sk] = sv
      end
    else
      k = k ? [k] : []
      a[k] = v
    end
    a
  end
end

class Hash
  def find_all_values_for(key)
    result = []
    result << self[key]
    self.values.each do |hash_value|
      values = [hash_value] unless hash_value.is_a? Array
      values.each do |value|
        result += value.find_all_values_for(key) if value.is_a? Hash
      end
    end
    result.compact
  end
end
