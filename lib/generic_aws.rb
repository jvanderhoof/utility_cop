class GenericAws

  def aws_object_from_id(resource_type, resource_id)
    "Aws::EC2::#{resource_type}".constantize.new(resource_id, client: ec2_client)
  end

  def time_this(msg)
    start_time = Time.now
    yield
    puts "#{msg} took: #{Time.now - start_time}"
  end

  def credentials
    @creds ||= Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def ec2_client
    @ec2_client ||= Aws::EC2::Client.new(region: 'us-east-1', credentials: credentials)
  end

  def vpc_scoped_name_filters(name)
    name_search_filters(name).push({name: 'vpc-id', values: [vpc.id]})
  end

  def name_search_filters(name)
    [
      {name: 'tag-key', values: ['Name']},
      {name: 'tag-value', values:[name]}
    ]
  end

  def name_tags(name)
    [{key: 'Name', value: name}]
  end

end