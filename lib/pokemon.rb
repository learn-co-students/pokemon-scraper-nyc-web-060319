class Pokemon
  attr_reader :db
  attr_accessor :id, :name, :type, :hp

  def initialize(name:, type:, db:, id: nil, hitpoints: nil)
    @name = name
    @type = type
    @db = db
    @id = id
    @hp = hitpoints
  end

  def self.save(name, type, db)
    sql = <<-SQL
        INSERT INTO pokemon (name, type) 
        VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    id = db.execute("SELECT MAX(id) FROM pokemon;")[0][0]

    Pokemon.new(name: name, type: type, db: db, id: id)
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE id = ?;
    SQL

    poke_row = db.execute(sql, id)[0]

    # if poke_row[3] == nil
    #   Pokemon.new(id: poke_row[0], name: poke_row[1], type: poke_row[2], db: db, hitpoints: 60)
    # else
    Pokemon.new(id: poke_row[0], name: poke_row[1], type: poke_row[2], db: db, hitpoints: poke_row[3])
    # end
  end

  def alter_hp(new_hp, db)
    sql = <<-SQL
    UPDATE pokemon SET hp = ?
    WHERE id = ?;
    SQL

    db.execute(sql, new_hp, id)
    @hp = new_hp
  end
end
