import pytest

@pytest.mark.asyncio
async def test_get_animal_characteristics(factory):
    args = [
        int(''.join(str(ord(str(c))) for c in 'tests-erc721')),
        int(''.join(str(ord(str(c))) for c in 'T721')),
        1234,
    ]
    contract = await factory("token/ERC721/ERC721.cairo", args)

    token_id = (42, 0)
    animal = await contract.get_animal_characteristics(token_id).call()
    assert animal.result == (1, 7, 2)

    await contract.mint(1234, token_id).invoke()
    owner = await contract.ownerOf(token_id).call()
    assert owner.result.owner == 1234
