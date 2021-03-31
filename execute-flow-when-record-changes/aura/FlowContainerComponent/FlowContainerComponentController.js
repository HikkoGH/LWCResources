({
    init : function (component) {

        const showFlow = component.get("v.showFlow");
        component.set("v.showFlow", !showFlow);
        
    },

    handleShowFlowChange: function (component, event) {
        const flow = event.getParam("value") ? component.find("flowData") : component.find("flowData2");
       
        const inputVariables = [
            { name : "recordId", type : "String", value: component.get("v.recordId") }, 
        ];
        
        const flowName = component.get("v.flowName");

        flow.startFlow(flowName, inputVariables);
    }
	
})