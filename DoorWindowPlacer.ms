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
			
			/*local lastPoint, actualPoint;
			
			lastPoint = pickPoint snap:#3d;
			
			if classof lastPoint == point3 do
			(
				actualPoint = pickPoint snap:#3d rubberband:lastPoint;
			)
			
			openingLength = distance actualPoint lastPoint;
			
			print openingLength;*/
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 0 224;

)