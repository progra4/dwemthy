class Hashie < Hash
  def method_missing(method_name, *args)
    m = method_name.to_s

    if m.end_with?("=")
      self[m.gsub("=",'')] = args.first
    else
      self[m]
    end
  end
end
