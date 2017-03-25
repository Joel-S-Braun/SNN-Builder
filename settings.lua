settings = {
    ai_model = 'civilian',
    
	vincrement = 0.2,
	offset = 3,
	
	instance_key = {
		h='hidden_neuron',
		i='input_neuron',
		o='output_neuron',
		s='soft_mem_neuron',
	},

	synthesis = {
		d='dopamine',  -- happywappyness
		c='norephinephrine', -- fear
		p='substance_p', -- pain
		e='ephinephrine', -- adrenaline
		[' ']='action_p', -- action potential
	},
    
    increment = {
        ['['] = -0.1,
        [']'] = 0.1,
    },

	colours = {
		input_neuron = {138,0,253},
		soft_mem_neuron={253,0,138},
		hidden_neuron= {138,0,9},
		output_neuron= {138,138,0},

		dopamine= {9,0,138},
		norephinephrine = {138,138,9},
		ephinephrine = {238,9,138},
		substance_p = {138,0,9},
		action_p = {0,138,0},

		selected1 = {2,140,131},
		selected2 = {138,138,138}
	}
}