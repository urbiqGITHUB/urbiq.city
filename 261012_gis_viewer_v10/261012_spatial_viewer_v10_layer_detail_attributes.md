---
title: "Urbiq GIS prohlížečka v10 – vrstvy, filtry a atributy detailu"
created_at: "2026-10-12 09:48:09"
created_date: "2026-10-12"
created_by: "Codex - Kateřina Kováříková"
updated_at: "2026-10-13 00:15:00"
updated_by: "Codex"
revised_by: null
timezone: "Europe/Prague"
codex_dialogue: "local Codex desktop thread; URL not available in workspace context"
dialogue_iteration: 10
version_id: "URBIQ-GIS-V10-ATTRIBUTES-20261012-v1.0.0"
status: "pilot-internal"
scope: "Katalog vrstev, filtry, popup atributy a provenience GIS prohlížečky v10"
tags: ["GIS", "Zlín", "Power Apps", "územní plán", "KAM"]
---

# Urbiq GIS prohlížečka v10 – vrstvy, filtry a atributy detailu

## Purpose and aims

Tento dokument popisuje vrstvy, filtry, identifikátory a atributy zobrazované prohlížečkou v10. Slouží pro kontrolu dat a ruční synchronizaci. Runtime autoritou je katalog `261012_catalog_v10.json`; aplikace tento Markdown nenačítá.

Každý nakonfigurovaný atribut se v popupu zobrazí. Chybějící hodnota má text **Neuvedeno ve zdroji**, který se vykreslí šedě a netučně. Popup řadí uživatelské názvy, dokumentové kódy, obsah a zdroje a nakonec technická ID. Odvozené údaje jsou pomocné a nenahrazují závaznou textovou část územního plánu.

---

## Identita ploch ÚP

| Klíč | Uživatelský popisek | Význam | Jedinečnost |
|---|---|---|---|
| `areaNumber` | Číslo plochy | veřejné i. č. z textové části | není zaručena globálně |
| `fpId` | ID regulativu (FP_ID) | vazba na tabulku regulativů | není zaručena globálně |
| `featureId` | ID prvku GIS | `OBJECTID` nebo `FID` | pouze v dané vrstvě a vydání |
| `entityId` | ID kategorie rendereru | technický kód symbologie | není uživatelským ID plochy |
| `areaKey` | Interní klíč plochy | `layerId:release:featureId` | autoritativní klíč výběru ve vieweru |

Křížová tabulka všech 4 206 funkčních ploch je v souboru `261012_up_area_crosswalk_v10.csv`.

## Společný detail funkční plochy

| Pořadí | Klíč | Popisek | Formát | Prázdná hodnota |
|---:|---|---|---|---|
| 1 | `functionName` | Název PRZV | text | Neuvedeno ve zdroji |
| 2 | `location` | Lokalizace | text | Neuvedeno ve zdroji |
| 3 | `cadastralArea` | Katastrální území | text | Neuvedeno ve zdroji |
| 4 | `functionCode` | Kód PRZV | text | Neuvedeno ve zdroji |
| 5 | `areaNumber` | Číslo plochy | text | Neuvedeno ve zdroji |
| 6 | `fpId` | ID regulativu (FP_ID) | text | Neuvedeno ve zdroji |
| 7 | `transformationCode` | Kód transformační plochy | text | Neuvedeno ve zdroji |
| 8 | `studyCode` | Kód územní studie | text | Neuvedeno ve zdroji |
| 9 | `areaStatus` | Stav plochy | text | Neuvedeno ve zdroji |
| 10 | `designationType` | Typ vymezení | text | Neuvedeno ve zdroji |
| 11 | `useMethod` | Způsob využití | více řádků | Neuvedeno ve zdroji |
| 12 | `mainUse` | Hlavní využití | více řádků | Neuvedeno ve zdroji |
| 13 | `permittedUse` | Přípustné využití | více řádků | Neuvedeno ve zdroji |
| 14 | `conditionallyPermittedUse` | Podmíněně přípustné využití | více řádků | Neuvedeno ve zdroji |
| 15 | `prohibitedUse` | Nepřípustné využití | více řádků | Neuvedeno ve zdroji |
| 16 | `additionalConditions` | Doplňující podmínky | více řádků | Neuvedeno ve zdroji |
| 17 | `regulationAvailable` | Individuální regulativ | text | vždy zobrazeno |
| 18 | `heightLimits` | Výšková regulace – odvozeno z textu | seznam | Neuvedeno ve zdroji |
| 19 | `greenCoefficient` | Koeficient zeleně – odvozeno z textu | desetinné číslo | Neuvedeno ve zdroji |
| 20 | `oneHouseCondition` | Podmínka jednoho RD – odvozeno z textu | ano / prázdné | Neuvedeno ve zdroji |
| 21 | `derivedNote` | Poznámka k odvozeným údajům | více řádků | Neuvedeno ve zdroji |
| 22 | `sourceSection` | Kapitola textové části | text | Neuvedeno ve zdroji |
| 23 | `sourcePage` | Stránka PDF | celé číslo | Neuvedeno ve zdroji |
| 24 | `sourceUrl` | Oficiální zdroj | odkaz | odkaz na celý dokument |
| 25 | `featureId` | ID prvku GIS | celé číslo | Neuvedeno ve zdroji |
| 26 | `entityId` | ID kategorie rendereru | text | Neuvedeno ve zdroji |
| 27 | `areaKey` | Interní klíč plochy | text | Neuvedeno ve zdroji |

Regulativy se nepřenášejí mezi plochami jen na základě stejného kódu PRZV. U plochy bez `FP_ID` zůstávají nedostupné položky prázdné a pole `regulationAvailable` vysvětluje důvod.

## Kurátorované filtry

| Vrstva | Filtrovat podle | Kategorie | Logika |
|---|---|---|---|
| Budovy – podlažnost | Podlažnost | 1, 2, 3, 4–5, 6–8, 9–13, 14+ | OR uvnitř výběru |
| Bloky | Hustota, typologie, zastavěnost, podlažnost | vlastní barevné intervaly pro každou klasifikaci | jedna aktivní klasifikace, OR uvnitř výběru |
| Historická zástavba | Období výstavby | devět období | OR; společně s časovým filtrem AND |
| Projekty KAM | Stav projektu, typ projektu | tři stavy a sedm typů včetně Neuvedeno | OR uvnitř, AND mezi filtry |
| Technická infrastruktura 2025 | Druh infrastruktury | osm síťových kategorií | OR; ochranná pásma jsou výchozí vypnutá |
| Funkční plochy | Funkce PRZV, stav | funkce; stav / návrh / rezerva | OR uvnitř, AND mezi filtry |
| VPS/VPO | Kategorie VPS/VPO | sedm zdrojových kategorií | OR |
| Rozvojové plochy | Typ rozvojové plochy | zastavitelná, transformační, změna v krajině, rezerva | OR |
| Plochy územních studií | Typ studie | povinná studie, studie rezervní plochy | OR |

Prázdný výběr kategorií znamená **zobrazit vše**. Výběry se uchovávají po dobu otevření prohlížečky.

## Analytické překryvy

### Projekty KAM

Publikováno je 25 bodů z veřejné služby `Projekty_KAM/FeatureServer/0`. Detail zobrazuje název, číslo, rok, stav, roli KAM, typ, popis a veřejné přílohy. Pole `Autor_projektu` a `Projektový_manager` se do dlaždic, detailů ani balíčku nepřenášejí. Zdroj uvádí 14 aktivních projektů, devět projektů v přípravě a dva dokončené projekty; poslední doložená editace služby je 22. 11. 2023.

### Technická infrastruktura 2025

Publikováno je 155 522 prvků z 20 archivovaných podvrstev: 97 233 linií a 58 289 polygonů. Jedna karta vykresluje dvě MVT části `infrastructure_line` a `infrastructure_polygon`. Detail používá pouze bezpečný allowlist: kategorii, zdrojovou podvrstvu, geometrii, dimenzi, typ objektu, evidenční kód, datum aktualizace a technická ID. Vlastníci, správci, provozovatelé, editoři a další správní atributy jsou vyloučené.

Původní veřejný endpoint při kontrole 12. 10. 2026 vyžadoval token. Vrstva má proto stav `archived-public` a viditelné upozornění. Nejde o úplný koordinační výkres ani o závaznou část územního plánu.

## Překryvy územního plánu po změně č. 6

### Rozvojové plochy

Publikováno je 689 geometrických prvků propojených s aktuálním standardizovaným GIS zdrojem nebo ověřenou vrstvou rezerv. Detail rozšiřuje společná pole o `developmentType` a `verificationConditions`.

### Plochy územních studií

Publikováno je 21 geometrických prvků, které mají právní vazbu přes `FP_ID` a kód `US` nebo `RUS`. Dvě položky staršího převodníku se nepodařilo bezpečně přiřadit k aktuální geometrii a viewer je nezobrazuje. Detail doplňuje `studyType` a `studyConditions`.

Vrstva **Hodnoty území** byla z v10 zcela odstraněna. Její historie zůstává pouze ve v08; katalog, runtime, data a balíček v10 ji neobsahují.

## Odvozené údaje

Koeficient zeleně, výšková regulace a podmínka jednoho rodinného domu se získávají z pole `DOPLNUJICI_PODMINKY`. Viewer vždy zachovává původní text. Odvozená pole:

- neslouží ve v10 k filtrování;
- nesmějí být interpretována jako samostatný závazný regulativ;
- nesou upozornění **Automaticky odvozeno z textu**;
- musí se před rozhodovacím použitím zkontrolovat proti oficiálnímu PDF.

Audit publikovaných detailů našel 176 ploch s kandidátem výškové regulace, pět regulativů s koeficientem zeleně a čtyři plochy s podmínkou jednoho rodinného domu. Hodnoty koeficientu `0,5`, `0,6` a `70 %` jsou pro zobrazení normalizované na desetinné číslo. Všechny odvozené kandidáty vyžadují ruční kontrolu v původní pasáži.

## Barevnost a integrované kategorie ÚP

- Funkční plochy používají barvu odvozenou ze stavové kategorie zdrojového rendereru změny č. 6.
- Změna č. 6 zachovává barvu funkce PRZV a tmavší obrys.
- Stav má plnou výplň, návrh diagonální šrafu jedním směrem a rezerva pravidelný puntíkovaný vzor.
- Kategorie ve filtru používají stejný generátor symbolu jako mapa; samostatná legenda ve v10 není.
- Kód `OK` má v typologii obecný název. Popup zachovává konkrétní název připojeného regulativu.

## Přehled atributů podle vrstvy

| Vrstva | Pole detailu |
|---|---|
| Budovy – podlažnost | `buildingCode`, `floors`, `useCode` |
| Bloky | `Typy_bloků`, `Hustota`, `IZ`, `Index_podlaznosti` |
| Historická zástavba | `Obdobi_vystavby`, `Datum_od_date`, `Datum_do_date`, `Mapovy_podklad` |
| Projekty KAM | `name`, `projectNumber`, `year`, `status`, `kamRole`, `projectType`, `description`, `attachments`, technická ID |
| Technická infrastruktura 2025 | `category`, `objectType`, `evidenceCode`, `dimension`, `geometryType`, `updatedDate`, `sourceSubtype`, technická ID |
| Funkční plochy | společný detail a `label`, `category`, `identifier`, `status`, `description` |
| VPS/VPO | `label`, `type`, `identifier`, `areaNumber`, `description`, zdroj a technická ID |
| Rozvojové plochy | společný detail a `developmentType`, `verificationConditions` |
| Plochy územních studií | společný detail a `studyType`, `studyConditions` |
| OSM, ortofoto, katastr | bez výběrového detailu; karta obsahuje veřejné dokumenty |

## Podklady a veřejné dokumenty

OSM, ortofoto a katastr jsou tři nezávislé podklady. Lze je zapnout současně; jejich pevné pořadí je OSM, ortofoto a katastr. Odkazy na ArcGIS službu, oficiální PDF ÚP, dokumentaci ČÚZK a pravidla OpenStreetMap jsou součástí `documents[]` příslušné vrstvy. Bloková mapa odkazuje na bezpečnou veřejnou aplikaci KAM; rizikový surový endpoint je veden pouze v interní provenienci. Historická zástavba odkazuje na veřejnou zdrojovou službu.

## Ruční synchronizace

Při změně katalogu je nutné:

1. upravit `detail.fields`, `filters` nebo `typologies` v katalogu;
2. znovu vytvořit datové deriváty a audit;
3. aktualizovat tento dokument;
4. ověřit shodu katalogu, popupu, filtrů a zdrojových textů;
5. vytvořit nový ZIP, manifest a SHA-256.

## Zdroje a jejich role

| Zdroj | Role | Použití | Omezení |
|---|---|---|---|
| [ÚP Zlín – úplné znění po vydání změny č. 6](https://zlin.eu/file/6a61b5c6951c7505de0f99d6?) | oficiální textová autorita | kapitoly, tabulky, čísla ploch a podmínky | viewer dokument nenahrazuje |
| `192_Regulativy_Ploch_FeatureServer` | aktuální standardizovaný GIS zdroj | geometrie funkčních ploch a tabulka regulativů | jen část geometrií má `FP_ID` |
| `193_UP_zmena6_vyplne_FeatureServer` | zdroj rendereru změny č. 6 | barvy, obrysy, šrafování a kategorie | pilotní interní využití |
| `194_VPS_a_VPO_změna_6_FeatureServer` | zdroj VPS/VPO | geometrie a sedm kategorií | duplicitní geometrie jsou odstraněné |
| starší polygonová vrstva ÚP a vrstva rezerv | kontrolovaný převodník | čísla ploch, transformační a studijní vazby, rezervy | není geometrickou autoritou bez shody s aktuálním zdrojem |
| [Projekty KAM](https://services-eu1.arcgis.com/yNltvVkIFFzMClFD/ArcGIS/rest/services/Projekty_KAM/FeatureServer/0) | veřejný analytický zdroj | 25 bodů, atributy a šest veřejných příloh | data podle metadat nebyla aktualizována od 22. 11. 2023 |
| `072_Technická_infrastruktura_2025_FeatureServer` a `261009_inventory.json` | archivovaný analytický zdroj | 20 podvrstev a 155 522 geometrií | původní endpoint nyní vyžaduje token; chybí licence a kvalitní popis |
| [03Bloková mapa](https://experience.arcgis.com/experience/cdbcaf13bc4f88e743f5b6e66584b) | bezpečný veřejný přehled | veřejný odkaz v kartě blokové mapy | surový endpoint se kvůli potvrzenému privacy riziku nezveřejňuje |
| `261007_zlin_block_privacy_audit.json` | privacy audit | určuje povinné použití sanitizovaného derivátu bloků | technický audit, nikoliv právní posouzení |
| `261012_up_data_audit_v10.json` | strojový audit | počty, úplnost, duplicity a odvozené údaje | vzniká z publikovaných derivátů |
| zadání uživatelky v aktuálním dialogu Codex | autoritativní produktové zadání | konsolidace vrstev, názvy skupin, zařazení infrastruktury a pravidla zdrojů | není datovým zdrojem ÚP; přesná URL dialogu není dostupná |
| `date-versioned-artifacts`, `markdown-metadata-standards`, `urbiq-brand-artifacts` | procedurální pravidla | verzování, metadata dokumentu a vizuální systém | neurčují věcný obsah GIS dat |
