require ('pg')

class Property

attr_accessor :address, :build, :no_bedrooms, :value
attr_reader :id

  def initialize (options)
    @id = options["id"].to_i if options["id"]
    @address = options["address"]
    @build = options["build"]
    @no_bedrooms = options["no_bedrooms"].to_i
    @value = options["value"].to_i
  end

  def save()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "INSERT INTO property (address, build, no_bedrooms, value) VALUES ($1, $2, $3, $4) RETURNING *"

    values = [@address, @build, @no_bedrooms, @value]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM property WHERE id = $1"

    values = [@id]

    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "UPDATE property SET (address, build, no_bedrooms, value) = ($1, $2, $3, $4) WHERE id = $5"

    values = [@address, @build, @no_bedrooms, @value, @id]

    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM property"

    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map{|property_hash|Property.new(property_hash)}
  end

  def Property.delete_all
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "DELETE FROM property"

    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM property WHERE id = $1"

    values = [id]

    db.prepare("find_by_id", sql)
    properties = db.exec_prepared("find_by_id", values)
    db.close()
    found_property_hash = properties[0]
    return Property.new(found_property_hash)
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})

    sql = "SELECT * FROM property WHERE address = $1"

    values = [address]

    db.prepare("find_by_address", sql)
    properties = db.exec_prepared("find_by_address", values)
    db.close()
    found_property_hash = properties[0]
    return Property.new(found_property_hash)
  end
end
