/*function buildWindowModelOne boxObject =
(
	
)*/

boxObject = selection[1]; --to be removed

/*local*/ HEIGHT_OF_BOX = boxObject.height;

/*local*/ WIDTH_OF_BOX = boxObject.width;

/*local*/ LENGTH_OF_BOX = boxObject.length;

/*local*/ baseMarbleSize = 2;

/*local*/ baseMarbleOffset = 2;

/*local*/ hasMarble = true;

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

function setFaceSelectionMode =
(
	boxObject.modifiers[1].setEPolySelLevel #face;
)

function selectFaces faces =
(
	boxObject.modifiers[1].select #face faces;
)

function moveSelectionBy amount =
(
	boxObject.modifiers[1].moveSelection amount axis:boxObject.transform;
	boxObject.modifiers[1].Commit ();
)

function clone =
(
	boxObject.modifiers[1].buttonOp #cloneFace;
)

function clearSelectionSet =
(
	boxObject.modifiers[1].SetSelection #Face #{};
)

function slice position quatAngleRotation =
(
	boxObject.modifiers[1].SetOperation #SliceSelectedFaces

	boxObject.modifiers[1].slice_plane.rotation = quatAngleRotation;
	
	boxObject.modifiers[1].slice_plane.position = position;

	boxObject.modifiers[1].Commit ();
)

function extrudeSelectedFaces amount normalType:1 =
(
	boxObject.modifiers[1].SetOperation #ExtrudeFace
	boxObject.modifiers[1].extrudeFaceHeight = amount;
	boxObject.modifiers[1].extrudeFaceType = normalType;
	boxObject.modifiers[1].Commit ()
)

function addMarbleBase size offset boxHeight boxLength =
(
	selectFaces #{1};
	
	moveSelectionBy [0,0,size];
	
	selectFaces #{1..6};
	
	clone();

	moveSelectionBy [0,0,-size];
	
	clearSelectionSet();
	
	selectFaces #{8};
	
	moveSelectionBy [0,0,(size*2) - boxHeight];
	
	clearSelectionSet();
	
	selectFaces #{9};
	
	moveSelectionBy [0, -offset, 0];

	clearSelectionSet();

	selectFaces #{7..12};

	slice [0, -(boxLength/2), 0] (quat 0.707107 0 0 0.707107);

	clearSelectionSet();

	selectFaces #{10,16};

	extrudeSelectedFaces 2;
	
	clearSelectionSet();
)
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

addModifier boxObject (Edit_Poly());

setFaceSelectionMode();

if hasMarble do addMarbleBase baseMarbleSize baseMarbleOffset HEIGHT_OF_BOX LENGTH_OF_BOX;

