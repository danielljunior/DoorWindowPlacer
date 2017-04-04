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
		local axisX = 1;
		local axisY = 2;
		local axisZ = 3;
		local axis = #(x_axis, y_axis, z_axis);
		
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
		
		function getMeasure returnPoint: lastPoint: returnVector: =
		(
			local actualPoint, actualDistance;
			
			if classof lastPoint == point3 then
			(
				
				actualPoint = pickPoint snap:#3d rubberband:lastPoint;
				
				if ( isRightClick actualPoint ) do return false;
				
				actualDistance = distance lastPoint actualPoint;
				
				*returnPoint = actualPoint;
				
				*returnVector = actualPoint - lastPoint;
				
				return actualDistance;
			)
				
			if lastPoint == unsupplied then
			(
				actualPoint = pickPoint snap:#3d;
				
				if ( isRightClick actualPoint ) do return false;
				
				getMeasure returnPoint:returnPoint lastPoint:actualPoint returnVector:returnVector;
			)
		)
		
		function getPivotPoint initialPoint measures =
		(
			measures[1] = measures[1] * measures[4][1];
			measures[2] = measures[2] * measures[4][2];
			measures[3] = measures[3] * measures[4][3];
			
			
		)
		
		function getThreeMeasures =
		(
			local auxiliarLastPoint, auxiliarVector, pivotPoint, auxiliarMeasure;
			
			local mountingMeasures = #([0,0,0], [0,0,0], [0,0,0], [0,0,0]);
			
			mountingMeasures[4][2] = getMeasure returnPoint:&auxiliarLastPoint returnVector:&auxiliarVector;
				
			mountingMeasures[2] = -normalize (auxiliarVector);
			
			pivotPoint = auxiliarLastPoint;
			
			mountingMeasures[4][1] = getMeasure returnPoint:&auxiliarLastPoint lastPoint:auxiliarLastPoint returnVector:&auxiliarVector;
				
			mountingMeasures[1] = normalize (auxiliarVector);
			
			mountingMeasures[4][3] = getMeasure returnPoint:&auxiliarLastPoint lastPoint:auxiliarLastPoint returnVector:&auxiliarVector;
				
			mountingMeasures[3] = normalize (auxiliarVector);
			
			pivotPoint = getPivotPoint pivotPoint mountingMeasures;
			
			return mountingMeasures;
		)
		
		---------------------------------------------------------------------------------------------------------------
		----------------------------------------------------[CALLBACKS]--------------------------------------------
		---------------------------------------------------------------------------------------------------------------
		on getDimensionsButton pressed do
		(
			local ref, ang, auxpt;
			
			ref = getThreeMeasures();
			
			print ref;
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 500 224;

)