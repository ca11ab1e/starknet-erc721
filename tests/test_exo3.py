import pytest

@pytest.mark.asyncio
async def test_get_animal_characteristics(factory):
    args = [
        int(''.join(str(ord(str(c))) for c in 'tests-erc721')),
        int(''.join(str(ord(str(c))) for c in 'T721')),
        1234,
    ]
    contract = await factory("token/ERC721/ERC721.cairo", args)

    await contract.declare_animal(2, 4, 6).invoke()
    owner = await contract.ownerOf(token_id).call()
    assert owner.result.owner == 1234


0x01f8d9bfb5c07b44d75b3433e8ce2dbf7b5a5a6f61da7564a923d70dadde5172