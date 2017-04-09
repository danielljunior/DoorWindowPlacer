/*function buildWindowModelOne boxObject =
(
	
)*/

boxObject = selection[1]; --to be removed

/*local*/ HEIGHT_OF_BOX = boxObject.height;

/*local*/ WIDTH_OF_BOX = boxObject.width;

/*local*/ LENGTH_OF_BOX = boxObject.length;

/*local*/ baseMarbleSize = 2;

/*local*/ baseMarbleOffset = 2;

function setFaceSelectionMode =
(
	boxObject.modifiers[1].setEPolySelLevel #face;
)

function selectFace faces =
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

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

addModifier boxObject (Edit_Poly());

setFaceSelectionMode();

selectFace #{1};
	
moveSelectionBy [0,0,baseMarbleSize];
	
selectFace #{1..6};
	
clone();

moveSelectionBy [0,0,-baseMarbleSize];
	
clearSelectionSet();
	
selectFace #{8};
	
moveSelectionBy [0,0,(baseMarbleSize*2) - HEIGHT_OF_BOX];
	
clearSelectionSet();
	
selectFace #{9};
	
moveSelectionBy [0, -baseMarbleOffset, 0];