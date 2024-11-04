import xml.etree.ElementTree as ET
import json

def parse_xml_to_json(xml_file):

    # parse the xml file
    tree = ET.parse(xml_file)
    root = tree.getroot()

    # initialise list to store method data
    abstract_methods = []

    # loop through abstract method
    for method in root.findall("abstract_method"):

        # initialise method dictionary and extract method name
        method_data = {
            "method_name": method.get("name")
        }

        # add visibility if necessary
        visibility = method.find("visibility")
        if visibility is not None:
            method_data["visibility"] = visibility.text

        # extract arguments
        arguments = method.find("arguments")
        parameters = []
        if arguments is not None:
            for param in arguments.findall("parameter"):
                param_data = {
                    "datatype": param.get("type"),
                    "label": param.text
                }
                parameters.append(param_data)
        method_data["arguments"] = {"parameter": parameters}

        # extract exceptions
        exceptions = []
        for exception in method.findall("exceptions/exception"):
            exceptions.append(exception.text)
        method_data["exceptions"] = {"exception": exceptions}

        # extract return type
        return_type = method.find("return")
        if return_type is not None:
            method_data["return"] = return_type.text

        # append the method data to the list
        abstract_methods.append(method_data)

    # structure as final JSON output
    json_output = {
        "abstract_method": abstract_methods
    }

    # convert json_output dictionary to json string
    print(json.dumps(json_output, indent=4))

# run function
parse_xml_to_json("WebServiceProvider.xml")
