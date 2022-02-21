//Works
//  ContractCompoents.swift
//  web3Interaction
//
//  Created by Mitchell Tucker on 5/14/21.
//

import Foundation

// Methods available within the contract
enum ContractMethods:String {

    case projectContract = "projectContent"
    case setContract = "setContract"
    case getDate = "getDate"
    case getLeafletHash = "getLeafletHash"
}

let contractAddress = contractAddressHash
let contractABI =
    """
    [
        {
            "inputs": [],
            "name": "date",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "getDate",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "getLeafletHash",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "leafletHash",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "initialLeafletHash",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "initialDate",
                    "type": "string"
                }
            ],
            "name": "projectContent",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "newLeafletHash",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "newInitialDate",
                    "type": "string"
                }
            ],
            "name": "setContract",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        }
    ]
"""
