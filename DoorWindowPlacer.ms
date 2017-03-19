--DoorWindowPlacer | version 0.0;

macroscript DoorWindowPlacer category: "Montelo Tools"
(
	Rollout DoorWindowPlacerDialog "Door/Window Placer"
	(
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[INTERFACE]------------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		
		group "Object Selection" 
		(
			button getDimensionsButton "Get Dimensions" height:35 width:200;
		)
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[VARIABLES]------------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		
		local openingLength, openingWidth, openingHeight;
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[FUNCTIONS]------------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		
		function isRightClick click =
		(
			if (click == #rightClick or click == undefined) then return true;
			else return false;
		)
		
		function getAngleBetween vector1 vector2 =
		(
			local returningAngle = acos( dot(normalize vector1)(normalize vector2) );
			
			returningAngle;
		)
		
		function getLineAxisRotation axis pointCoordinate1 pointCoordinate2=
		(
			local groundedVector, answerAngle;
			
			local isSecondYGreater = pointCoordinate1.y < pointCoordinate2.y;
			
			groundedVector = pointCoordinate1 - pointCoordinate2;
			
			answerAngle = (getAngleBetween [1,0,0] groundedVector);
			
			if isSecondYGreater do answerAngle = -answerAngle;
				
			answerAngle;
		)
		
		
		
		function getMeasure &returnPoint &returnAngle lastPoint: =
		(
			local actualPoint, actualDistance;
			
			if classof lastPoint == point3 then
			(
				
				actualPoint = pickPoint snap:#3d rubberband:lastPoint;
				
				if ( isRightClick actualPoint ) do return false;
				
				actualDistance = distance lastPoint actualPoint;
				
				returnPoint = actualPoint;
				
				returnAngle = getZWorldAngle actualPoint lastPoint;
				
				--returnAngle = getAngleBetween [1,0,0] (actualPoint-lastPoint);
				
				return actualDistance;
			)
				
			if lastPoint == unsupplied then
			(
				actualPoint = pickPoint snap:#3d;
				
				if ( isRightClick actualPoint ) do return false;
				
				getMeasure &returnPoint &returnAngle lastPoint:actualPoint;
			)
		)
		
		function getThreeMeasures =
		(
			local auxiliarLastPoint;
			
			local mountingMeasures = #(0, 0, 0, 0);
			
			mountingMeasures[1] = getMeasure &auxiliarLastPoint;
			
			for axis = 2 to 3 do
			(
				if classof auxiliarLastPoint == #rightClick do return false;
				
				mountingMeasures[axis] = getMeasure &auxiliarLastPoint lastPoint:auxiliarLastPoint;
			)
			
			--mountingMeasures[4] = getAngleBetween 
			
			return mountingMeasures;
		)
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[CALLBACKS]--------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		on getDimensionsButton pressed do
		(
			local ref, ang, auxpt;
			
			ref = getMeasure &auxpt &ang;
			
			print ang;
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 500 224;

)