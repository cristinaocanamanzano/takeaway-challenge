class TakeAway
  DEFAULT_AMOUNT = 1
  attr_reader :order_list, :menu
  def initialize(menu = Menu.new)
    @order_list = []
    @menu = menu
  end

  def display_menu
    menu.display_menu
  end

  def order(dish, amount = DEFAULT_AMOUNT)
    raise "This dish is not in our menu" unless menu.dish_included?(dish)
    order_list << {
      dish: dish,
      amount: amount,
      price: calculate_price(dish, amount)
    }
    print_confirmation(dish, amount)
  end

  def order_summary
    if order_list.empty?
      puts "You have not added anything yet"
    else
      order_list.each do |order|
        puts "#{order[:amount]} #{order[:dish]}(s), £#{order[:price]}"
      end
    end
  end

  def print_total_price
    puts "The total price is £#{total_price}."
  end

  private

  def calculate_price(dish, amount)
    amount * menu.dish_price(dish)
  end

  def print_confirmation(dish, amount)
    if amount == DEFAULT_AMOUNT
      puts "1 #{dish} has been added to your order list"
    else
      puts "#{amount} #{dish}s have been added to your order list"
    end
  end

  def total_price
    order_list.map { |order| order[:price] }.reduce(:+)
  end
end
