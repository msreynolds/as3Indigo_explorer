/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/18/12
 * Time: 11:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.view.components.renderers {
    import com.perceptiveautomation.indigo.device.IIndigoDevice;

    import flash.events.MouseEvent;

    import spark.components.Label;
    import spark.components.supportClasses.ItemRenderer;
    import spark.events.ListEvent;

    public class IndigoDeviceListItemRenderer extends ItemRenderer {

    private var _indigoDevice:IIndigoDevice;

    // Child Display Objects
    private var _labelDeviceName:Label;


    public function IndigoDeviceListItemRenderer() {
        this.height = 28;
        this.doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseDoubleClick);
    }

    override public function set data(value:Object):void {

        if (value is IIndigoDevice) {
            _indigoDevice = value as IIndigoDevice;
        }
    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_labelDeviceName) {
            _labelDeviceName = new Label();
            _labelDeviceName.text = (_indigoDevice !== null) ?_indigoDevice.name : "Name Not Available";
            _labelDeviceName.left = 7;
            _labelDeviceName.top = 9;
            this.addElement( _labelDeviceName );
        }
    }

    override protected function commitProperties():void {
        super.commitProperties();
        _labelDeviceName.text = (_indigoDevice !== null) ?_indigoDevice.name : "Name Not Available";

    }

    private function handleMouseDoubleClick(event:MouseEvent):void {
        var listEvent:ListEvent = new ListEvent("showItemDetail",false,false,NaN,NaN,null,false,false,false,false,0,-1,this.data, this);
        this.owner.dispatchEvent(listEvent);
    }
}

}
