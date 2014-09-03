require 'pry'

def most_expensive
  max = {}
  restaurants.each do |restaurant, menu|
    menu[:meals][:breakfast].each do |name, values|
      max[values[:price_in_cents]] = name
    end
    menu[:meals][:lunch].each do |name, values|
      max[values[:price_in_cents]] = name
    end
  end
  max.max_by{|price, item| price}[1]
end

def one_of_everything_from(name)
  price = 0
  restaurants.each do |restaurant, menu|
    if restaurant == name
      menu[:meals][:breakfast].each do |name, values|
        price += values[:price_in_cents]
      end
      menu[:meals][:lunch].each do |name, values|
        price += values[:price_in_cents]
      end
    end
  end
  price * 0.01
end

def monthly_egg_count
  egg_count = []
  restaurants.each do |restaurant, menu|
    hours = menu[:hours]
    eggs = 0
    menu[:meals][:breakfast].each do |name, values|
      values[:ingredients].each do |item|
        if item == "eggs"
          eggs += 2
        end
      end
    end
    menu[:meals][:lunch].each do |name, values|
      values[:ingredients].each do |item|
        if item == "eggs"
          eggs += 2
        end
      end
    end
    eggs = ((eggs * 8) * hours) * 30
    egg_count << eggs
  end
  egg_count.reduce(:+)
end

def lactose_free_items
  lactose_free = []
   restaurants.each do |restaurant, menu|
    menu[:meals][:breakfast].each do |name, values|
      if !values[:ingredients].include?("cheese")
        lactose_free << name
      end
    end
    menu[:meals][:lunch].each do |name, values|
      if !values[:ingredients].include?("cheese")
        lactose_free << name
      end
    end
  end
  lactose_free
end



# restaurant data
def restaurants
  {
    "Sam's Sandwhiches" => {
      hours: 7,
      meals: {
        breakfast: {
          hamncheese: {
            price_in_cents: 499,
            ingredients: ["ham", "cheese", "english muffin"]
          },
          mcwaffle: {
            price_in_cents: 525,
            ingredients: ["waffles", "syrup", "sausage", "cheese"]
          }
        },
        lunch: {
          meatball_rollup: {
            price_in_cents: 709,
            ingredients: ["meatballs", "cheese", "tortilla"]
          },
          fluffer_nutter_with_bacon: {
            price_in_cents: 639,
            ingredients: ["bread", "fluff", "peanutbutter", "bacon"]
          }
        }
      }
    },
    "Adam's Veggie Express" => {
      hours: 9,
      meals: {
        breakfast: {
          asparagus_omlette: {
            price_in_cents: 688,
            ingredients: ["eggs", "cheese", "asparagus"]
          },
          fajita_frittata: {
            price_in_cents: 500,
            ingredients: ["eggs", "green peppers", "red peppers", "yellow peppers", "onions", "cheese"]
          }
        },
        lunch: {
          veggie_surprise_bag: {
            price_in_cents: 925,
            ingredients: ["tomato", "onion", "squash", "other stuff"]
          },
          corn_on_the_cob: {
            price_in_cents: 229,
            ingredients: ["corn"]
          }
        }
      }
    },
    "Eric's Emo Eats" => {
      hours: 3,
      meals: {
        breakfast: {
          sad_cereal: {
            price_in_cents: 277,
            ingredients: ["cereal", "milk"]
          },
          apathetic_eggs: {
            price_in_cents: 320,
            ingredients: ["eggs"]
          }
        },
        lunch: {
          mopey_falafels: {
            price_in_cents: 625,
            ingredients: ["pita", "falafel", "tahini"]
          },
          tearful_tacos: {
            price_in_cents: 719,
            ingredients: ["beef", "taco shells", "cheese", ]
          }
        }
      }
    }
  }
end

