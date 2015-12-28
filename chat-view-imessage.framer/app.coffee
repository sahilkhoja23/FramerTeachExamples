# Import file "chat"
$ = Framer.Importer.load("imported/chat@1x")
$.start.x = 0
$.start.y = 0
$.screen.x = 0
$.screen.y = 0

$.start.states.add
	move: (x: -1000, time: 0.5)


$.Buttons.on Events.Click, ->
	$.start.states.switch("move")

	

# Make the chat view scrollable
scroll = ScrollComponent.wrap($.scroll)
# Add a little padding on the bottom
scroll.contentInset = 
	bottom: 32
# Set default scroll position 
scroll.scrollY = scroll.content.height
# Disable horizontal scrolling
scroll.scrollHorizontal = false



# Set the beginner state for the microphone icon
$.iconMicActive.visible = false

# Animate the indicator
$.indicator.animate 
	properties: 
		opacity: 0
	time: 0.5
	delay: 0.25
	repeat: 100

# On tap, animate & scale the icon
$.iconMic.on Events.Click, ->
	$.iconMicActive.visible = true
	$.iconMicActive.scale = 0.8
	$.iconMicActive.opacity = 0
	
	# Animate the active state
	$.iconMicActive.animate
		properties:
			scale: 1
			opacity: 1
		time: 0.4
		
	# Fade the text field
	$.inputContent.animate 
		properties:
			opacity: 0
		time: 0.4
		
	# After 0.4 seconds, fade-out the active state again
	$.iconMicActive.on Events.AnimationEnd, ->
		this.animate 
			properties:
				opacity: 0
			time: 0.4
			
	# After 2 seconds, make the text-field re-appear
	# Also hide the active state again
	Utils.delay 2, ->
		$.inputContent.animate 
			properties:
				opacity: 1
			time: 0.4
			
		$.iconMicActive.visible = false