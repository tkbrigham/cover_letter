'''
Determines whether or not to interview a Candidate, "me". Assumes equal weight of all assessment criteria (25%).
**Needs refactoring:
    1) Need to add sectional breaks for each raw_input, such that it only asks the incorrectly
    answered question again instead of asking all questions again
'''
# dict for converting "low-high" values to numbers
val_pairs = {"low": 1,"med-low": 2,"med": 3,"med-high": 4,"high": 5}

# define Candidate class
class Candidate(object):
    def __init__(self):
        # 'pro' attributes
        self.motivation = "high"
        self.fast_learner = "high"
        self.has_potential = "med-high"
        # 'con' attributes
        self.formal_training = "low"
        self.experience = "med-low"

    def to_number(self,a):
        return val_pairs[self.__dict__[a]]

# define functions to check inputs
def prob_found():
    print " -- ENTER APPROPRIATE INPUT, PLEASE! -- "
    print " -- I NEED TO ASK EVERYTHING AGAIN -- "
    print
    return False

def check_number_input(input):
    if (len(input) > 1) or (len(input) == 0) or (1 > int(input)) or (int(input) > 5):
##            print "ed = ", ed
##            print "len of ed > 1: ", (len(ed) > 1)
##            print "len of ed = 0: ", (len(ed) == 0)
##            print "1 > ed: ", 1 > int(ed)
##            print "ed > 5: ", int(ed) > 5
##            candidate_can_debug = True
        return prob_found()        

# define function for calculating if candidate should get interview   
def worth_interview(candidate):
    education = ""
    exp_or_pot = ""
    motivation = ""
    ability_to_train = ""
    
    while True:
        # prompt/calculate importance of education
        education = raw_input("Does a formal education matter significantly for this position(y/n)? ")
        if education == "n":
            education = 15 + candidate.to_number("formal_training")*2
        elif education == "y":
            education = candidate.to_number("formal_training")*5
        else:
            prob_found()
            break
        print "---"

        # prompt/calculate preference: experience or potential       
        exp_or_pot = raw_input("Which is more important for this position: experience or potential('e' or 'p')? ")
        if (exp_or_pot == "e"):
            exp_or_pot = 5*candidate.to_number('experience')
        elif (exp_or_pot == "p"):
            exp_or_pot = 5*candidate.to_number('has_potential')
        else:
            prob_found()
            break
        print "---"

        # prompt/calculate importance of motivation
        motivation = raw_input("On a scale of 1 to 5 (5 being the most), how important is the candidate's motivation? ")
        if check_number_input(motivation) == False:
            break
        motivation = int(motivation)*candidate.to_number('motivation')
        print "---"

        # prompt/calculate time to train potential candidates
        ability_to_train = raw_input("On a scale of 1 to 5 (5 being the most), how much time can you afford to spend training the candidate, if hired? ")
        if check_number_input(ability_to_train) == False:
            break
        ability_to_train = int(ability_to_train)*candidate.to_number('fast_learner')
        print "---"

        # calculate candidate score
        cand_score = 0
        for i in [education, exp_or_pot,motivation,ability_to_train]:
            cand_score += i
        break
    
    # start over if any of the inputs were invalid    
    if "" in [education, exp_or_pot, motivation, ability_to_train]:
        return worth_interview(candidate)

    print "Candidate score is: ", cand_score
    if cand_score > 60:
        print "Definitely worth a shot!"
    else:
        print "It's a stretch, but you never know!"
           
me = Candidate()   
worth_interview(me)


