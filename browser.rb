require 'net/http'
require 'nokogiri'

require_relative 'page'

class Browser
  @@commands = ['help','exit']

  def run!
    # Run the browser
    # Display a prompt for a user
    # Parse their input
    # Display useful results by instantiating
    #   a new Page and calling methods on it.
    
    # Questions:
    #  1. How can a user quit the browser gracefully?
    #  2. How can a user ask for help, i.e., how do they know what commands are available to them?
    puts "This is the world dumbest browser.\n - To begin, type in any valid url.\n - To quit, type 'exit' (without the quotes).\n - To see list of available commands, type 'help' (without the quotes)."
    begin
      print "\nType in your url here:\nurl> "
      url = gets.chomp.downcase
      case url
      when "exit"
        puts "Exiting browser.."
        sleep 0.5
        puts "Browser closed!"
        break
      when "help"
        help
        next
      else
        page = Page.new(url)
        page.fetch!
        page.title
        page.links
      end
    end while true
  end

  def help
    puts "\nShowing list of available commands:"
    puts " - help: show list of available commands"
    puts " - exit: quit the browser"
    puts "\n\n"
    sleep(2)
    print "Redirecting"
    3.times do 
      sleep 2
      print ". "
    end
    puts 
  end

end

Browser.new.run!