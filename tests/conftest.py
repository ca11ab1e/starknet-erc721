"""contract.cairo test file."""
from pathlib import Path

import pytest
from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
CONTRACT_DIR = Path(__file__).parent.parent / "contracts"


@pytest.fixture()
async def factory():
    async def create(name: str, args = None):
        starknet = await Starknet.empty()
        return await starknet.deploy(
            source=str(CONTRACT_DIR / name),
            constructor_calldata=args,
        )

    return create
