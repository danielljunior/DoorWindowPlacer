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
			
			if axis == x_axis do
			(
				groundedVector = pointCoordinate1 - pointCoordinate2;
				
				answerAngle = getAngleBetween y_axis groundedVector;
				
				if pointCoordinate1.z > pointCoordinate2.z do answerAngle = -answerAngle;
			)
			
			if axis == y_axis do
			(
				groundedVector = pointCoordinate2 - pointCoordinate1;
				
				answerAngle = getAngleBetween z_axis groundedVector;
				
				if pointCoordinate1.x > pointCoordinate2.x do answerAngle = -answerAngle;
			)
			
			if axis == z_axis do
			(
				groundedVector = pointCoordinate2 - pointCoordinate1;
				
				groundedVector.z = 0;
				
				answerAngle = getAngleBetween x_axis groundedVector;
				
				if pointCoordinate1.y > pointCoordinate2.y do answerAngle = -answerAngle;
			)
			
			return answerAngle;
		)
		
		
		
		function getMeasure returnPoint: rotationAxis: returnAngle: lastPoint: =
		(
			local actualPoint, actualDistance;
			
			if classof lastPoint == point3 then
			(
				
				actualPoint = pickPoint snap:#3d rubberband:lastPoint;
				
				if ( isRightClick actualPoint ) do return false;
				
				actualDistance = distance lastPoint actualPoint;
				
				*returnPoint = actualPoint;
				
				*returnAngle = getLineAxisRotation rotationAxis lastPoint actualPoint;
				
				return actualDistance;
			)
				
			if lastPoint == unsupplied then
			(
				actualPoint = pickPoint snap:#3d;
				
				if ( isRightClick actualPoint ) do return false;
				
				getMeasure returnPoint:returnPoint rotationAxis:rotationAxis returnAngle:returnAngle lastPoint:actualPoint;
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
			
			ref = getMeasure returnPoint:&auxpt rotationAxis:y_axis returnAngle:&ang;
			
			print ang;
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 500 224;

)