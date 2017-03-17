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
		
		function isRightClick click =
		(
			if (click == #rightClick or click == undefined) then return true;
			else return false;
		)
		
		function getDistance &returnPoint lastPoint: =
		(
			local actualPoint, actualDistance;
			
			if classof lastPoint == point3 then
			(
				
				actualPoint = pickPoint snap:#3d rubberband:lastPoint;
				
				if ( isRightClick actualPoint ) do return false;
				
				actualDistance = distance lastPoint actualPoint;
				
				returnPoint = actualPoint;
				
				return actualDistance;
			)
				
			if lastPoint == unsupplied then
			(
				actualPoint = pickPoint snap:#3d;
				
				if ( isRightClick actualPoint ) do return false;
				
				getDistance &returnPoint lastPoint:actualPoint;
			)
		)
		
		
		
		function getAngleBetween vector1 vector2 =
		(
			local returningAngle = acos( dot(normalize vector1)(normalize vector2) );
			
			returningAngle;
		)
		
		function getThreePoints =
		(
			local auxiliarLastPoint;
			
			local xyzDistances = #(0, 0, 0);
			
			xyzDistances[1] = getDistance &auxiliarLastPoint;
			
			for axys = 2 to 3 do
			(
				if classof auxiliarLastPoint == #rightClick do return false;
				
				xyzDistances[axys] = getDistance &auxiliarLastPoint lastPoint:auxiliarLastPoint;
			)
			
			return xyzDistances;
		)
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[CALLBACKS]--------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		on getDimensionsButton pressed do
		(
			
			local ref = #();
			
			ref = getThreePoints();
			
			print ref;
			
			/*local auxiliarLastPoint;
			openingLength = getDistance &auxiliarLastPoint;
			
			print openingLength;
			
			openingWidth = getDistance &auxiliarLastPoint lastPoint:&auxiliarLastPoint;
			
			print openingWidth;
			
			openingHeight = getDistance &auxiliarLastPoint lastPoint:&auxiliarLastPoint;
			
			print openingHeight;*/
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 500 224;

)