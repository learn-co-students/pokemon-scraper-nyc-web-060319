class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(keywords)
  # (id:, name:, type:, db:) #passing in whole hash & then setting the keys values or initializing them
  @id = keywords[:id]
  @name  = keywords[:name]
  @type = keywords[:type]
  @db  = keywords[:db]

  end


#dont have to pass into db into DATABASE-- DOESNT MAKE SENSE
  def self.save(name, type, db) #passing in args bc we're saving instances that  we init. & dont have to call it again as self.name or self.type
    sql = <<-SQL
    INSERT INTO pokemon(name, type)
    VALUES(?,?)
    SQL
    db.execute(sql, name, type) #db is being passed in as an instance of the class so dont need to call it like db[:conn]
  end


  def self.find(id, db) #passing in db to search through the correct db & find correct id also

    sql = <<-SQL
    SELECT *
    FROM pokemon
    WHERE id = ?
    SQL

    pokemon = db.execute(sql, id)[0]
    #returns 2-d array & you need the first index of that arr which is the id.
    newHash  = {
      :id  => pokemon[0],
      :name => pokemon[1],
      :type => pokemon[2],
      :db => db
    }
    # puts pokemon[0]
    # puts "---------------------------"
    Pokemon.new(newHash)
  end





end
