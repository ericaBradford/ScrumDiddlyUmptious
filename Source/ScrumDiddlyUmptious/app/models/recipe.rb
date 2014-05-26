class Recipe < ActiveRecord::Base

#associations
  belongs_to :user
  has_many :comments

  has_many :favorite_recipes
  has_many :users, through: :favorite_recipes, source: :user

#validations
  validates :title, :ingredients, :directions, :cookTime, :costOfIngredients, :id_Users, :description, :category, :picture, presence: true
  validates :title, length: {in: 4..40, message: "must be 4-100 characters long"}
  validates :title, uniqueness: {case_sensitive: false, message: "There is already a recipe with that name"}
  validates :description, length: {in: 10..300, message: "must be 10-300 characters long"}
  validates :description, format: {with: /[0-9A-Za-z.!?,:]+/, message: "may only consist of letters, numbers, and basic punctuation."}
  validates :directions, length: {in: 25..15000, message: "should be 30-15000 characters long"}
  validates :cookTime, format: {with: /[0-9]+ [a-zA-Z]+[a-zA-Z0-9 ]*/, message: "must be in the form '3 hours' or '3 hrs 29 minutes'"}
  validates :costOfIngredients, numericality: true
  validates :costOfIngredients, format: {with: /[0-9]{1,3}(?:,?[0-9]{3})*(?:\.[0-9]{2})?/, message: " can only be in the form '39.00'"}
  validates :ingredients, length: {in: 5..1000, message: "need to be longer."}
  validates :id_Users, format: {with: /[0-9]+/, message: "should only be in number form."}

#paperclip stuff
  has_attached_file :picture, :styles => { :medium => "400x400>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

#letsrate
letsrate_rateable "Rating"

#sunspot search functionality
  searchable do
    text :title, :boost => 5
    text :ingredients, :boost => 3
    text :directions, :description, :category
    string :average_rating
    double :costOfIngredients
    boolean :canPrepareAhead
  end

  def average_rating
    @average_rating_record = RatingCache.find_by_sql("SELECT * FROM Rating_caches WHERE cacheable_id = #{id}")
    @average_rating = @average_rating_record.first.avg.to_f
    return @average_rating
  end

  def numIngredients
    @number = self.ingredients.lines.count
    return @number
  end

  def cookTimeInMinutes
    @cookTimeArray = self.cookTime.split(" ")
    if @cookTimeArray.count == 4
      if @cookTimeArray[1] == "hour" || @cookTimeArray[1] == "hr" || @cookTimeArray[1] == "hours" || @cookTimeArray[1] == "hrs"
        @cookTimeMins = (@cookTimeArray[0] * 60) + @cookTimeArray[2]
      elsif @cookTimeArray[3] == "hour" || @cookTimeArray[3] == "hr" || @cookTimeArray[3] == "hours" || @cookTimeArray[3] == "hrs"
        @cookTimeMins = (@cookTimeArray[2] * 60) + @cookTimeArray[0]
      end
    elsif @cookTimeArray.count == 2
      if @cookTimeArray[1] == "minutes" || @cookTimeArray[1] == "min" || @cookTimeArray[1] == "minutes" || @cookTimeArray[1] == "mins"
        @cokTimeMins = @cookTimeArray[0]
      end
    else
      @cookTimeMins = "Uh oh!"
    end
    #@cookTimeMins = 
    return @cookTimeMins
  end


#constants
  def self.meat
    ["chicken", "pork", "beef", "steak", "meat", "jello", "marshmellows", "parmigiano-reggiano", "gummy"]
  end

  def self.fish
    ["anchovies", "bass", "catfish", "cod", "flounder", "grouper", "haddock", "hake", "halibut", "herring", "mahi mahi", "perch", "pike", "pollock", "salmon", "scrod", "swordfish", "sole", "snapper", "tilapia", "trout", "tuna", "caesar salad", "caesar dressing", "worcestershire", "bouillapaisse", "fish", "imitation fish", "imitation shellfish", "imitation crab", "meatloaf", "barbecue sauce", "caponata"]
  end

  def self.shellfish
    ["lobster", "oyster", "shrimp", "clam", "crab", "sushi"]
  end

  def self.alcohol
    ["alcohol", "amaretto", "beer", "bourbon", "champagne", "grand marnier", "rum", "tequila", "whisky", "wine", "vodka", "liquer"]
  end

  def self.dairy
    ["aart", "amasi", "Ayran", "baked milk", "basundi", "bhuna khoyo", "blaand", "black kashk", "booza", "buffalo curd", "bulgarian yogurt", "2% milk", "regular milk", "2 percent milk", "two percent milk", "whole milk", "1% milk", "land o lakes butter", "buttermilk", "yogurt", "cheese", "cream", "gelato", "ice cream", "whey", "2% milk", "regular milk", "2 percent milk", "two percent milk", "whole milk", "1% milk", "land o lakes butter", "country crock butter"]
  end

  def self.egg
    ["egg", "eggs", "omelete", "quiche"]
  end

  def self.soy
    ["soy", "edamame", "miso", "tempeh", "tofu"]
  end

  def self.wheat
    ["wheat", "flour", "bread", "pasta", "cake", "cookie", "noodle", "pizza", "cereal"]
  end

  def self.gluten
     ["white flour", "whole wheat flour", "durum wheat", "wheat", "graham flour", "triticale", "kamut", "semolina", "spelt", "wheat germ", "wheat bran", "pasta", "noodles", "flour tortillas", "cookie", "cake", "muffin", "pastry", "cereal", "crackers", "beer", "oats", "gravy", "dressing"]
  end

  def self.treenut
    ["nut", "almond", "cashew", "filbert", "pecan", "pistachio", "macadamia"]
  end

  def self.peanut
    ["peanuts", "granola", "chex mix", "blackberry punch", "cherry punch", "molasses", "candy bar", "buttermilk", "caramel", "cream cheese", "cheese nut sage", "cheese pimento", "cheese sandwich", "chili", "chop suey", "cocoa", "cooking oil", "curd", "instant coffee", "mayo", "meat substitute", "mock", "pancake flour", "pickle", "salad oil", "vinegar", "worcestershire"]
  end

  def self.poultry
    ["chicken", "duck", "geese", "turkey", "quail", "egg", "eggs", "omelete", "quiche", "squab", "guinea fowl"]
  end

end
