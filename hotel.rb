#creating a structure for managing hotel rooms
#for simplicity, input will all be on command line, at least at first.
# I want to create a reservation like for Hyatt
# Need: database to hold reservations, dates, classes like rooms/hotel/
#Lets model a hotel: What would be the hierarchy?
#There would be
#minimum viable product is 1. ability to book room types and dates
#2.check whether those rooms are booked on desired dates
#3 Do i need a separate class for each type of room?
#4 I need to make sure the inputs are only dates
class Build
	attr_accessor :rooms
	def initialize(name)
		@name = name
		@rooms = Array.new
		@rooms << Room.new("e",name)
		@rooms << Room.new("c",name)
	end
end


class Room
	#availability can be a boolean
	attr_accessor :bookings, :hotel_name
	attr_reader :room_number, :room_count, :price, :room_type
	#room count can be a tallying class variable, and also used to determine room number
	#room price can depend on the type, do i need to have it here?
	@@room_count = 0
	#need to have a variable that gathers all bookings
	#and a variable that has all current rooms
	def initialize(room_type,hotel_name)
		if room_type == 'e'
			@room_type = 'e'
			@price = 500
		else
			@room_type = 'c'
			@price = 200
		end
		@@room_count += 1
		@room_number = @@room_count
		#vacant for all days, how do i model days?, array for now
		@bookings ||= []
	end
	#add booking to room
	def book(day)
		#book per day, lets start with one day
		if booked?(day) == false
			#mark booked
			@bookings << day
			puts 'Successfully booked'
		else
			puts 'Not available'
		end
	end
	#depends on the days right	
	#You cant use falsy and truthy, empty array does not mean false, it just means its empty, its not nil
	def booked?(day)
		#yes until someone books it
		found = @bookings.select {|b| b == day}
		if found.empty?
			return false
		else
			return true
		end
	end
end
class Bookings
	#I want available dates to book
	# when booked, I want the room type and dates to be entered
	# I guess the room object will hold its own bookings?


	#Now we want to ask consumers which rooms they'd like to book and when
	def self.prompt(klass_obj)
		puts 'There are two types of rooms, cheep and expensive. Please pick one'
		room_type = gets.chomp
		#I know know the room class/type

		puts 'Which date would you like to book this room?'

		day = gets.chomp
		#I know the type and the date.
		#I want to pick the first room of that type(eventually will loop through the rooms) and check if that date is booked
		#I will iterate through the type of room selected, and see if there are any rooms available
		if room_type == 'e'
			klass_obj.rooms.each do |r|
				if r.room_type == 'e'
					if r.booked?(day) == false
						r.book(day)
						break
					end
				end
				puts "Not Available"
			end
			
		end
		if room_type == 'c'
			klass_obj.rooms.each do |r|
				if r.room_type == 'c'
					if r.booked?(day) == false
						r.book(day)
						break
					end
				end
			end
		end
	end

	def self.find_rooms(klass_obj)
	end	
end
class Expensive < Room
	def initialize(hotel_name)
		@price = 500
		@hotel_name = hotel_name	
	end
end

class Cheap < Room
	def initialize(hotel_name)
		@price = 200
		@hotel_name = hotel_name	
	end
end

class Start
	@@marriot = Build.new('marriot')
	Bookings.prompt(@@marriot)
	Bookings.prompt(@@marriot)
	Bookings.prompt(@@marriot)
	
	def self.marriot
		@@marriot
	end
end
