package utils

import (
	"context"
	"fmt"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/accounts/keystore"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
	ticket "github.com/mogza/abs-ticketing/gen"
	"math/big"
	"os"
)

type event struct {
	name             string
	symbol           string
	eventName        string
	eventDate        *big.Int
	maxSupply        *big.Int
	ticketPrice      *big.Int
	baseURI          string
	organizerAddress common.Address
}

func DeployContract() {
	b, err := os.ReadFile(os.Getenv("KEYSTORE_PATH"))
	LogFatal(err, "Error reading keystore file")

	key, err := keystore.DecryptKey(b, os.Getenv("KEYSTORE_PASSWORD"))
	LogFatal(err, "Error decrypting key")

	client, err := ethclient.Dial("https://api.testnet.abs.xyz")
	LogFatal(err, "Error connecting to testnet")
	defer client.Close()

	chainID, err := client.NetworkID(context.Background())
	LogFatal(err, "Error getting chain ID")

	auth, err := bind.NewKeyedTransactorWithChainID(key.PrivateKey, chainID)
	LogFatal(err, "Error creating auth")

	eventInfo := event{
		name:             "testDeployment",
		symbol:           "TD",
		eventName:        "TestEvent",
		eventDate:        new(big.Int).SetUint64(1750000000),
		maxSupply:        new(big.Int).SetUint64(1000),
		ticketPrice:      new(big.Int).SetUint64(1000000000000000),
		baseURI:          "ipfs://exampleBaseURI/",
		organizerAddress: common.HexToAddress("0xeB472D4a1608332d825E1E9E9E19e5c7054c8F96"),
	}

	a, tx, _, err := ticket.DeployTicket(auth, client, eventInfo.name, eventInfo.symbol, eventInfo.eventName, eventInfo.eventDate, eventInfo.maxSupply, eventInfo.ticketPrice, eventInfo.baseURI, eventInfo.organizerAddress)

	fmt.Println("Deployed contract : ", a.Hex())
	fmt.Println("Transaction Hash : ", tx.Hash().Hex())
}
