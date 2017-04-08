--DoorWindowPlacer | version 0.0;

macroscript DoorWindowPlacer category: "Montelo Tools"
(
	Rollout DoorWindowPlacerDialog "Door/Window Placer"
	(
		-----------------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------[INTERFACE]----------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		
		group "Object Selection" 
		(
			button getDimensionsButton "Get Dimensions" height:35 width:200;
		)
		
		-----------------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------[VARIABLES]----------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		
		local openingLength, openingWidth, openingHeight;
		local axisX = 1;
		local axisY = 2;
		local axisZ = 3;
		local axis = #(x_axis, y_axis, z_axis);
		
		-----------------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------[FUNCTIONS]----------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		
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
				
				if (returnpoint != unsupplied) do *returnPoint = actualPoint;
				
				if (returnVector != unsupplied ) do *returnVector = normalize (actualPoint - lastPoint);
				
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
			pivotPoint = (measures[1]*(measures[4][2]/2)) + (measures[2]*(measures[4][1]/2)) + initialPoint;
			
			return pivotPoint;
		)
		
		function getThreeMeasures =
		(
			local auxiliarLastPoint, auxiliarVector, pivotPoint, auxiliarMeasure;
			
			local mountingMeasures = #([0,0,0], [0,0,0], [0,0,0], [0,0,0], [0,0,0]);
			
			mountingMeasures[4][1] = getMeasure returnPoint: &auxiliarLastPoint returnVector:&auxiliarVector;
			
			mountingMeasures[2] = -auxiliarVector;
			
			pivotPoint = auxiliarLastPoint;
			
			mountingMeasures[4][2] = getMeasure returnPoint: &auxiliarLastPoint lastPoint:auxiliarLastPoint returnVector:&auxiliarVector;
			
			mountingMeasures[1] = auxiliarVector;
			
			mountingMeasures[4][3] = getMeasure returnPoint: &auxiliarLastPoint lastPoint:auxiliarLastPoint returnVector:&auxiliarVector;
			
			mountingMeasures[3] = auxiliarVector;
			
			pivotPoint = getPivotPoint pivotPoint mountingMeasures;
			
			mountingMeasures[5] = pivotPoint;
			
			return mountingMeasures;
		)
		
		function spawnBaseBox mountingMeasures =
		(
			boxObject = box length: mountingMeasures[4][1] width: mountingMeasures[4][2] height: mountingMeasures[4][3];
			
			transformMatrix = matrix3 1;
			
			for axis=1 to 3 do transformMatrix[axis] = mountingMeasures[axis];
			
			boxObject.transform = transformMatrix;
			
			boxObject.pos = mountingMeasures[5];
			
			return boxObject;
		)
		
		function generateInitialFrame =
		(
			local mountingMeasures = getThreeMeasures();
			
			boxObject = spawnBaseBox mountingMeasures;
			
			return boxObject;
		)
		
		-----------------------------------------------------------------------------------------------------------------------------------
		--------------------------------------------------------------[CALLBACKS]----------------------------------------------------------
		-----------------------------------------------------------------------------------------------------------------------------------
		
		on getDimensionsButton pressed do
		(
			generateInitialFrame();
		)
	)
	
	CreateDialog DoorWindowPlacerDialog 218 320 555 590;

)
