/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/19/12
 * Time: 10:25 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.view.components {
import com.perceptiveautomation.indigo.actiongroup.IIndigoActionGroup;

import flash.events.MouseEvent;

import spark.components.Label;
import spark.components.supportClasses.ItemRenderer;
import spark.events.ListEvent;

public class IndigoActionGroupListItemRenderer extends ItemRenderer {

    // Child Display Objects
    private var _labelActionGroupName:Label;
    private var _labelActionGroupDescription:Label;
    private var _labelActionGroupFolder:Label;

    private var _indigoActionGroup:IIndigoActionGroup;

    public function IndigoActionGroupListItemRenderer() {
        this.height = 28;
        this.doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseDoubleClick);
    }

    override public function set data(value:Object):void {

        if (value is IIndigoActionGroup) {
            _indigoActionGroup = value as IIndigoActionGroup;
        }
    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_labelActionGroupName) {
            _labelActionGroupName = new Label();
            _labelActionGroupName.text = (_indigoActionGroup !== null) ? _indigoActionGroup.name : "Name Not Available";
            _labelActionGroupName.left = 7;
            _labelActionGroupName.top = 9;
            this.addElement( _labelActionGroupName );
        }

        if (!_labelActionGroupDescription) {
            _labelActionGroupDescription = new Label();
            _labelActionGroupDescription.text = (_indigoActionGroup !== null) ? _indigoActionGroup.description : "-";
            _labelActionGroupDescription.horizontalCenter = 0;
            _labelActionGroupDescription.top = 9;
            this.addElement( _labelActionGroupDescription );
        }

        if (!_labelActionGroupFolder) {
            _labelActionGroupFolder = new Label();
            _labelActionGroupFolder.text = (_indigoActionGroup !== null) ? _indigoActionGroup.folder : "-";
            _labelActionGroupFolder.right = 7;
            _labelActionGroupFolder.top = 9;
            this.addElement( _labelActionGroupFolder );
        }

    }

    override protected function commitProperties():void {
        super.commitProperties();
        _labelActionGroupName.text = (_indigoActionGroup !== null) ? _indigoActionGroup.name : "Name Not Available";
        _labelActionGroupDescription.text = (_indigoActionGroup !== null) ? _indigoActionGroup.description : "-";
        _labelActionGroupFolder.text = (_indigoActionGroup !== null) ? _indigoActionGroup.folder : "-";

    }

    private function handleMouseDoubleClick(event:MouseEvent):void {
        var listEvent:ListEvent = new ListEvent("showItemDetail",false,false,NaN,NaN,null,false,false,false,false,0,-1,this.data, this);
        this.owner.dispatchEvent(listEvent);
    }

}
}
