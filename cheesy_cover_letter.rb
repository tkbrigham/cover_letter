# By: Thomas Brigham
# Phone: 571-435-5250
# Email: tkbrigham@gmail.com
# Github: https://github.com/tkbrigham

####
# Determines whether or not to interview a Candidate, "me". Assumes equal 
# weight of all assessment criteria (25%). 
####


######
### DEFINE CANDIDATE CLASS
######
class Candidate
	@@rating_to_val = { low: 1, med_low: 2, med: 3, med_high: 5, high: 5 }
	
	attr_accessor :motivation, :fast_learner, :has_potential, :formal_training, :experience

	def initialize(motivation, fast_learner, has_potential, formal_training, experience)
		# 'pro' attirbutes
		@motivation = motivation
		@fast_learner = fast_learner
		@has_potential = has_potential
		# 'con' attributes
		@formal_training = formal_training
		@experience = experience
	end

	def convert_to_val(att)
		@@rating_to_val[self.method(att).call.to_sym].to_i
	end

	def worth_interview?
		education = determine_education(self)
		puts "-------"
		
		exp_or_pot = determine_exp_or_pot(self)
		puts "-------"
		
		motivation = determine_motivation(self)
		puts "-------"
		
		training = determine_training(self)
		puts "-------"

		cand_score = calculate_score(education, exp_or_pot, motivation, training)
		
		puts "Candidate score is: #{cand_score}"
		if cand_score > 60
			puts "Definitely worth a shot!"
		else
			puts "It's a stretch, but you never know!"
		end
	end
end

######
### PROGRAM FUNCTIONS
######
def prob_found
	puts
	puts " -- ENTER APPROPRIATE INPUT, PLEASE! -- "
	puts
end

def check_number_input(input)
	if 1 > input.to_i || input.to_i > 5
		return false
	end
end

# prompt/calculate importance of education
def determine_education(candidate)
	puts "Does a formal education matter significantly for this position(y/n)? "
	education = gets.chomp
	if education == "n"
		education = 15 + candidate.convert_to_val("formal_training")*2
	elsif education == "y"
		education = candidate.convert_to_val("formal_training")*5
	else
		prob_found
		determine_education(candidate)
	end		
end

# prompt/calculate preference: experience or potential
def determine_exp_or_pot(candidate)
	puts "Which is more important for this position: experience or potential('e' or 'p')? "
	exp_or_pot = gets.chomp
	if exp_or_pot == "e"
		exp_or_pot = 5*candidate.convert_to_val('experience')
	elsif exp_or_pot == "p"
		exp_or_pot = 5*candidate.convert_to_val('has_potential')
	else
		prob_found
		determine_exp_or_pot(candidate)
	end	
end

# prompt/caluclate importance of motivation
def determine_motivation(candidate)
	puts "On a scale of 1 to 5 (5 being the most), how important is the candidate's motivation?"
	motivation = gets.chomp
	if check_number_input(motivation) == false
		prob_found
		determine_motivation(candidate)
	else
		motivation = motivation.to_i*candidate.convert_to_val('fast_learner')
	end
end

# prompt/caluclate ability to train/mentor potential candidates
def determine_training(candidate)
	puts "On a scale of 1 to 5 (5 being the most), how much training and/or mentoring are you planning on providing to the candidate?"
	ability_to_train = gets.chomp
	if check_number_input(ability_to_train) ==false
		prob_found
		determine_training(candidate)
	else
		ability_to_train = ability_to_train.to_i*candidate.convert_to_val('fast_learner')
	end
end

# calculate candidate score
def calculate_score(education, exp_or_pot, motivation, training)
	cand_score = [education, exp_or_pot, motivation, training].reduce(:+)
end

me = Candidate.new(
	motivation = "high",
	fast_learner = "high", 
	has_potential = "med_high", 
	formal_training = "low", 
	experience = "med")

me.worth_interview?

