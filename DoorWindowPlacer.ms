--DoorWindowPlacer | version 0.0;

macroscript DoorWindowPlacer category: "Montelo Tools"
(
	Rollout DoorWindowPlacerDialog "Door/Window Placer"
	(
		---------------------------------------------------------------------------------------------------------------
		--------------------------------------------------[INTERFACE]---------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		
		group "Object Selection" 
		(
			button getDimensionsButton "Get Dimensions" height:35 width:200;
		)
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[VARIABLES]--------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		
		local openingLength, openingWidth, openingHeight;
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[FUNCTIONS]------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		
		function getDistance &returnPoint &lastPoint:undefined =
		(
			local actualPoint, actualDistance;
			
			if classof lastPoint == point3 then
			(
				actualPoint = pickPoint snap:#3d rubberband:lastPoint;
				
				actualDistance = distance lastPoint actualPoint;
				
				returnPoint = actualPoint;
				
				actualDistance;
			) else (
				actualPoint = pickPoint snap:#3d;
				
				getDistance &returnPoint lastPoint:actualPoint;
			)
			
		)
		
		function getAngleBetween vector1 vector2 =
		(
			local returningAngle = acos( dot(normalize vector1)(normalize vector2) );ing
			
			returningAngle;
		)
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[CALLBACKS]--------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		on getDimensionsButton pressed do
		(
			local auxiliarLastPoint;
			openingLength = getDistance &auxiliarLastPoint;
			
			print openingLength;
			
			openingWidth = getDistance &auxiliarLastPoint lastPoint:&auxiliarLastPoint;
			
			print openingWidth;
			
			openingHeight = getDistance &auxiliarLastPoint lastPoint:&auxiliarLastPoint;
			
			print openingHeight;
			
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 500 224;

)